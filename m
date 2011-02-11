From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Roberto Jimenez)
Date: Fri, 11 Feb 2011 11:50:23 -0200
Subject: [PATCH 1/4] RTC: Include information about UIE and PIE in RTC driver
	proc.
Message-ID: <1297432224-14001-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

On Fri, Feb 11, 2011 at 10:34, Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br> wrote:
Hi John,

On Thu, Feb 10, 2011 at 21:06, John Stultz <john.stultz@linaro.org> wrote:
>
>> This seems to be mostly formatting changes. Are you sure we wont' break
>> applications expecting the existing format?
>>
> No, I can't be 100% sure, ...

While reworking the patch, I can be 100% sure it would break because it fixed a typo and changed two names, so it was not white space at all.

The reworked patch follows.

Regards,
Marcelo.
