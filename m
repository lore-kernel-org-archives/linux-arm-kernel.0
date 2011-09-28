From: sebastian.rasmussen@stericsson.com (Sebastian RASMUSSEN)
Date: Wed, 28 Sep 2011 11:05:37 +0200
Subject: [PATCH 1/3] mmc: mmci: Put power register deviations in variant
	data
In-Reply-To: <CACRpkdZoXmQiUJbLkzgTkRnjukS18RvcZASXzZshnuDSQDE1aQ@mail.gmail.com>
References: <1317123725-29832-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdZoXmQiUJbLkzgTkRnjukS18RvcZASXzZshnuDSQDE1aQ@mail.gmail.com>
Message-ID: <ECD438FDEF6BD742895E554C24725A401C4F1AE0D7@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > + ? ? ? unsigned int ? ? ? ? ? ?pwrreg_powerup;
>
> This should probably be u32, no big deal but easy to fix.
> Can be done when putting it into Russells patch tracker I guess.

Agreed, since pwr is u32 where pwrreg is used, it should be.

 / Sebastian
