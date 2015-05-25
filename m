From: rob@landley.net (Rob Landley)
Date: Mon, 25 May 2015 02:14:28 -0500
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <1432322832.5304.63.camel@opteya.com>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com>
 <1432322832.5304.63.camel@opteya.com>
Message-ID: <CAOS_Y6Q37ps+VEnzUZ_uwX++qrRm9Hgx45Q_pmiZSLSNjmKwZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 2:27 PM, Yann Droneaud <ydroneaud@opteya.com> wrote:
> I've added licensing at fsf.ogrg in Cc: in my previous message to have an
> advice on this subject, but I failed to notice licensing at fsf.org
> is not a mailing list: I was assigned request ID [gnu.org #1017262].
>
> Regards.

They're also not an unbiased source. Their job is to reply "you should
license it under GPLv3" without actually looking at your message.
(This is a slight oversimplification, they may instead recomend the
GFDL. They will never _not_ recommend one of their licenses.)

Personally, I'm sad we're starting to get ACPI for arm but if device
tree data files are only available under GPL, people will hold their
nose and deploy ACPI.

Rob
