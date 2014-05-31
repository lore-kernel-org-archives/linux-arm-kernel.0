From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 May 2014 20:08:42 -0700
Subject: [GIT PULL] qcom driver changes for v3.16-2
In-Reply-To: <20140530235720.GA27752@kroah.com>
References: <alpine.DEB.2.00.1405301138220.5291@galak-ubuntu.qualcomm.com>
 <20140530235720.GA27752@kroah.com>
Message-ID: <CAOesGMjhFLD=Rkz0SqSav9qfAzWBCXLf03b=5=xj0uZzz6KwdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 4:57 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, May 30, 2014 at 11:41:01AM -0500, Kumar Gala wrote:
>> The following changes since commit 5d144e36b7c51612922fa05d37ff3a869261cc82:
>>
>>   soc: qcom: Add GSBI driver (2014-05-23 11:38:04 -0500)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-drivers-for-3.16-2
>>
>> for you to fetch changes up to 31964ffebbb958c6cf289c7c12edd7530d6221b9:
>>
>>   tty: serial: msm: Remove direct access to GSBI (2014-05-29 11:06:20 -0500)
>>
>> ----------------------------------------------------------------
>> Qualcomm ARM Based driver Updates for v3.16-2
>>
>> * Updated MSM uart driver to not access GSBI control registers
>>
>> ----------------------------------------------------------------
>> Andy Gross (1):
>>       tty: serial: msm: Remove direct access to GSBI
>>
>>  drivers/tty/serial/msm_serial.c | 48 ++---------------------------------------
>>  drivers/tty/serial/msm_serial.h |  5 -----
>>  2 files changed, 2 insertions(+), 51 deletions(-)
>
> Do you want me to take these in the tty tree?  Or are they going to go
> through the arm tree(s) for other reasons (dependancies)?

In the other thread about this patch
(http://marc.info/?l=linux-kernel&m=140137951814522&w=2), he claimed:

"I?ll send it via arm-soc as the related patches are going via that path."

I'm not fussed either way. I haven't touched these branches yet.


-Olof
