From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 24 Jan 2013 18:13:03 +0800
Subject: [alsa-devel] [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB530BB@DBDE01.ent.ti.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
 <20130123154804.GB4565@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB52FD9@DBDE01.ent.ti.com>
 <20130124100252.GE4955@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB530BB@DBDE01.ent.ti.com>
Message-ID: <20130124101301.GG4955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 10:06:42AM +0000, Hebbar, Gururaja wrote:

> What I meant was that by using this macro (SND_SOC_DAPM_POST_PMU &
> SND_SOC_DAPM_PRE_PMD) I can just save and restore existing voltage values inside
> the event. They will not be user configurable (available to user through some widget).

Well, you *could* add separate register control for that but it's not
really something that should obviously be exposed to users; usually
that'd be something that is fixed by the platform via platform data.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130124/a36077fa/attachment.sig>
