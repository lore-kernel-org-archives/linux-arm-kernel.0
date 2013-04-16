From: girishks2000@gmail.com (Girish KS)
Date: Tue, 16 Apr 2013 16:58:47 +0530
Subject: [PATCH V4 2/5] spi: s3c64xx: added support for polling mode
In-Reply-To: <20130416112035.GD26958@opensource.wolfsonmicro.com>
References: <1366015230-18243-1-git-send-email-ks.giri@samsung.com>
 <20130416112035.GD26958@opensource.wolfsonmicro.com>
Message-ID: <CAKrE-Kd4Vis0-V_n8zEzqJVBbEYvTiYS8hY_7s7AnUqaK2tFCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 4:50 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 15, 2013 at 02:10:27PM +0530, Girish K S wrote:
>> From: Girish K S <girishks2000@gmail.com>
>>
>> The 64xx spi driver supports partial polling mode.
>> Only the last chunk of the transfer length is transferred
>> or recieved in polling mode.
>
> I'm missing patch 1 of this series.

its already  merged to stable tree after your review
