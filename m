From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Nov 2013 22:38:13 -0800
Subject: [PATCH] spi: davinci: Fix the build warning with CONFIG_ARM_LPAE=y
In-Reply-To: <20131001104840.GL19304@sirena.org.uk>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
 <20131001104840.GL19304@sirena.org.uk>
Message-ID: <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 1, 2013 at 3:48 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 30, 2013 at 02:52:59PM -0400, Santosh Shilimkar wrote:
>> With CONFIG_ARM_LPAE=y spi driver throws below warning
>
> Applied, thanks.

These warnings are showing up (again?), so wherever it was applied is
not making it into -next. Did it fall between the cracks?


-Olof
