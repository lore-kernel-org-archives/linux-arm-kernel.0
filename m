From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Mar 2018 15:52:27 -0700
Subject: [PATCH] ARM: BCM5301X: Fix NAND ECC parameters for Linksys
 Panamera
In-Reply-To: <20180311100313.znonhesgh462rz65@osboxes>
References: <20180310171244.70299-1-npcomplete13@gmail.com>
 <CACna6rz1TeRbPq-60HkHz9A0TDn+iXtmXniE6FCiANpUmV-qrw@mail.gmail.com>
 <20180311100313.znonhesgh462rz65@osboxes>
Message-ID: <2ef6e4fc-cce7-372e-e35f-578fd6ada9ca@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2018 03:03 AM, Vivek Unune wrote:
> Hi Rafa?,
> 
> On Sat, Mar 10, 2018 at 10:41:04PM +0100, Rafa? Mi?ecki wrote:
>> On 10 March 2018 at 18:12, Vivek Unune <npcomplete13@gmail.com> wrote:
>>> Using BCH8 gives ecc errors and makes the router unsuable.
>>> Switching to BCH1 fixes these errors.
>>
>> Can you provide CFE's log messages starting with
>> "Decompressing...done" and up to the "Press Ctrl+C to stop in CFE"
>> please? I'd like to see what NAND info CFE prints there.
> 
> See below. It does say BCH-8, however I can't get it to work.
> 
> CFE log:
> 
> Decompressing...done
> Found a Toshiba NAND flash:
> Total size:  128MB
> Block size:  128KB
> Page Size:   2048B
> OOB Size:    64B
> Sector size: 512B
> Spare size:  16B
> ECC level:   8 (8-bit)
> Device ID: 0x98 0xf1 0x80 0x15 0xf2 0x16
> find_devinfo: devinfo block found at 0x00180000!
> 
> Press Ctrl+C to stop in CFE

What kind of error are you getting in Linux with BCH-8?
-- 
-- 
Florian
