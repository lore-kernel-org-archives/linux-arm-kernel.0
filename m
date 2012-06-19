From: p.pisati@gmail.com (Paolo Pisati)
Date: Tue, 19 Jun 2012 18:53:15 +0200
Subject: MMC: commit dba3c29 ruins mmc card data on beagle-xm revB
In-Reply-To: <CANrkHUaxJGcv2bdUWTCB_oKct-iFCKCdb7OQPTUjS4MuKeCS2w@mail.gmail.com>
References: <CACVXFVO-Wm1Qwporby1M=+yPz81AWHpZRBZSbr5tgT32b6sSEA@mail.gmail.com>
 <CANrkHUYd8Ww6De4MiZ8_oPfcnhvtsZXOySLRiWSBU4QUQ6beHw@mail.gmail.com>
 <CACVXFVP16UmHe-GGydrSMgGHwnkSvYhnY339=zr=BfCehvS8Kw@mail.gmail.com>
 <CANrkHUaxJGcv2bdUWTCB_oKct-iFCKCdb7OQPTUjS4MuKeCS2w@mail.gmail.com>
Message-ID: <4FE0AE7B.4040502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2012 05:28 PM, T Krishnamoorthy, Balaji wrote:
> On Mon, Jun 11, 2012 at 12:50 PM, Ming Lei <ming.lei@canonical.com> wrote:
>>
>> On Mon, Jun 11, 2012 at 2:21 PM, T Krishnamoorthy, Balaji
>> <balajitk@ti.com> wrote:
>>> Hi Ming Lei,
>>> Can you let me know if you noticed any write/timeout errors ?
>>
>> Nothing error logs found during writing.
> Hi,
> 
> Couldn't reproduce the issue with BeagleXM rev C, Might be a combination
> of rev and SD card. How often do you see mis-match in file content?

i just want to say that i'm affected by this too, and i can reproduce it
100%.

do you want me to run that patch or you already have enough data?
-- 
bye,
p.
