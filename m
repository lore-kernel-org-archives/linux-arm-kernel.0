From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 24 Jan 2013 10:06:42 +0000
Subject: [alsa-devel] [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
In-Reply-To: <20130124100252.GE4955@opensource.wolfsonmicro.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
 <20130123154804.GB4565@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB52FD9@DBDE01.ent.ti.com>
 <20130124100252.GE4955@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB530BB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 15:32:55, Mark Brown wrote:
> On Thu, Jan 24, 2013 at 09:33:34AM +0000, Hebbar, Gururaja wrote:
> 
> > So, by just using the SND_SOC_DAPM_POST_PMU & SND_SOC_DAPM_PRE_PMD I can mask 
> > & handle one particular voltage. 
> 
> What makes you say that?  That is just not true.

What I meant was that by using this macro (SND_SOC_DAPM_POST_PMU &
SND_SOC_DAPM_PRE_PMD) I can just save and restore existing voltage values inside
the event. They will not be user configurable (available to user through some widget).


> 


Regards, 
Gururaja
