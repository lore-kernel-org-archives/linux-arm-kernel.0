From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 2 Sep 2017 12:08:31 +0200
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for ProBox2
In-Reply-To: <CAD4Jqzs=SHBGOrACbGiURxsz8OEcp9NpUZV-vkkLqXtBV97XoQ@mail.gmail.com>
References: <20170827125425.3400-1-afaerber@suse.de>
 <20170827125425.3400-2-afaerber@suse.de>
 <20170831211427.7pmjdd5n4baes3d4@rob-hp-laptop>
 <CAD4Jqzs=SHBGOrACbGiURxsz8OEcp9NpUZV-vkkLqXtBV97XoQ@mail.gmail.com>
Message-ID: <7c7224a9-b0a6-caa4-483a-d9613af48d13@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wilson,

Please note that HTML-format mails are not permitted on most Linux
mailing lists, so your below message did not arrive for the other reviewers.

Am 01.09.2017 um 04:11 schrieb PROBOX2-CS:
> Hi Rob,
> 
> For the company of the brand is W2COMP COMPANY LIMITED or you can write
> PROBOX2.

My updated proposal is:

probox2         PROBOX2 (by W2COMP Co., Ltd.)

Rationale: Repeating the same name with just different casing on the
right does not provide additional information to a reader wondering whom
this prefix belongs to and whether to use it for new compatible strings.

If that proposal is okay with you, we still need to figure out how to
describe your company in the commit message below.

> thanks,
> Wilson
> PROBOX2
> 
> On Fri, Sep 1, 2017 at 5:14 AM, Rob Herring <robh@kernel.org
> <mailto:robh@kernel.org>> wrote:
> 
>     On Sun, Aug 27, 2017 at 02:54:23PM +0200, Andreas F?rber wrote:
>     > PROBOX2 is a Hong Kong based manufacturer of TV boxes.

W2COMP describes itself as an "online reseller", and PROBOX2 does not
have any About Us page to derive a fair description from - "reseller"
appears to contradict my above description as "manufacturer".
Therefore my (unanswered) off-list inquiry from Aug 28, when you first
mentioned W2COMP to me.

So what about: "PROBOX2 is a TV box brand by Hong Kong based online
reseller W2COMP Company Limited."?

CC'ing William.

Thanks,
Andreas


>     >
>     > Cc: support at probox2.com <mailto:support@probox2.com>
>     > Signed-off-by: Andreas F?rber <afaerber@suse.de
>     <mailto:afaerber@suse.de>>
>     > ---
>     >  I did not find a fully spelled out company name for this brand.
>     >
>     >  http://probox2.com/contact-us/
>     >  https://www.facebook.com/pg/probox2/about/
>     <https://www.facebook.com/pg/probox2/about/>
>     >
>     >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>     >  1 file changed, 1 insertion(+)
> 
>     Acked-by: Rob Herring <robh at kernel.org <mailto:robh@kernel.org>>

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
