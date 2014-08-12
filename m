From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue, 12 Aug 2014 13:18:56 -0700
Subject: Freescale: iMX6Q Sabre SD
In-Reply-To: <CACUGKYM-B18YKtbc1BE1=RvUwRTypt9iSwYgOmfXF7w2Yq_sBA@mail.gmail.com>
References: <CACUGKYM=jPGL+GB1=n9-UQPaphPv4ONQz3Fb5k9-5CA=Zx=1xw@mail.gmail.com>
 <CAOMZO5BJ6WS-OynZWJLE42pZbrvJ_nMM3qyndYVNsDYbBFWMmg@mail.gmail.com>
 <CAOMZO5BD5EE6ZpVCz0ST3j=hoXf4rk7PXOC3ZpWAHn_2nN8t7g@mail.gmail.com>
 <CACUGKYM-B18YKtbc1BE1=RvUwRTypt9iSwYgOmfXF7w2Yq_sBA@mail.gmail.com>
Message-ID: <CACUGKYNvj=WRz9gU84Qyo6CakTqU2MfegqPHxm9uYZd5s6o9Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

After applying the patches, it works...

Regards,

john

On Tue, Aug 12, 2014 at 8:10 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Fabio,
>
> Thanks for the info. I will check it.
>
> Regards,
>
> john
>
> On Tue, Aug 12, 2014 at 6:42 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> John,
>>
>> On Mon, Aug 11, 2014 at 10:31 AM, Fabio Estevam <festevam@gmail.com> wrote:
>>
>>> I tested on my mx6qsabresd revC4 / rev C and the PCI link is not
>>> detected just like you described.
>>
>> Tested again today and my rev C4 detects the PCI card in U-boot and in
>> the kernel.
>>
>> For U-boot I use top of tree u-boot-imx.
>>
>> For kernel I am using linux-next 20140811 plus two patches:
>>
>> 1. One patch from Lucas that allows the kernel to boot when the
>> bootloader has already configured PCI:
>>
>> http://thread.gmane.org/gmane.linux.kernel.pci/33712/focus=33711
>>
>> 2. A patch from Tim that fix occasional PCI linkup failures:
>>
>> http://www.spinics.net/lists/linux-pci/msg33520.html
>>
>> Let me know if using this kernel version allows your PCI card to be
>> detected on revC4 mx6qsabresd board.
