From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Feb 2015 11:40:25 +0900
Subject: [PATCH 5/6] ASoC: samsung: Extend Snow driver to support max98089
In-Reply-To: <CAD=FV=WkieDSSB_-a6DtH1hmq6SyZk4NAR-eXQ11hxUDMTvRfg@mail.gmail.com>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-6-git-send-email-afaerber@suse.de>
 <20150219094425.GB3198@finisterre.sirena.org.uk>
 <CAD=FV=WkieDSSB_-a6DtH1hmq6SyZk4NAR-eXQ11hxUDMTvRfg@mail.gmail.com>
Message-ID: <20150221024025.GB6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 09:44:08AM -0800, Doug Anderson wrote:
> On Thu, Feb 19, 2015 at 1:44 AM, Mark Brown <broonie@kernel.org> wrote:

> I think what you're suggesting is that here we should add a new
> compatible string "google,snow-audio" instead of adding
> "google,snow-audio-max98089" here.  Then the sound node in the spring
> DTS would look like:

>   compatible = "google,snow-audio-max98089", "google,snow-audio";

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150221/746cb36c/attachment.sig>
