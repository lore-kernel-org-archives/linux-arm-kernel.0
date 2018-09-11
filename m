From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 11 Sep 2018 11:56:49 +0200
Subject: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
In-Reply-To: <20180911094430.GG4185@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell> <20180911084548.GC4185@dell>
 <20180911090132.GB25161@kroah.com> <20180911094430.GG4185@dell>
Message-ID: <743b5545-e942-b6f4-4ce6-8e10950a05fc@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2018 at 11:44, Lee Jones wrote:
> On Tue, 11 Sep 2018, Greg KH wrote:
> 
>> On Tue, Sep 11, 2018 at 09:45:48AM +0100, Lee Jones wrote:
>>> On Mon, 10 Sep 2018, Lee Jones wrote:
>>>
>>>> Enjoy!
>>>>
>>>> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>>>>
>>>>    Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
>>>>
>>>> for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
>>>>
>>>>    tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> Immutable branch between MFD, SPI and TTY due for the v4.20 merge window
>>>
>>> Due to a comedy of errors, I'm voiding this pull-request.
>>
>> Um, I can't do that as my tree can not be rebased :(
> 
> Oh dear. :(
> 
>> I can take follow-on patches, so I will go apply the patch posted so
>> that my tree builds again.  I recommend you just apply it as well.
> 
> What a pickle.  As per my last email, it looks as though this set was
> applied under false pretences.  The MFD patch which was carrying my
> Ack was doing so incorrectly.  The author mistakenly applied it to the
> wrong patch.  After re-review (actually initial review) I wish to NACK
> the implementation.

What? We discussed this to the bone!

Radu followed all the recommendations, collected all the feedback from 
major subsystems SPI and USART, resent the series again.

It was then forgotten. Wrong series was finally applied (which could 
trigger 0-day reports, I warn you)... and now we are discussing about 
the implementation of *v2* (we're at v12)!

> My suggestion would be to sit tight, rather than do anything rash and
> see how this plays out.  After which we can fix your tree.

Come on, Greg's tree is fixed now. We can catch-up with v11..v12 changes 
with patches and cleanup the mess together.

Just one misalignment with one patch merged for v4.19-rc1, fixed the 
same day, cannot generate such a reaction after months of development.

Best regards,
-- 
Nicolas Ferre
