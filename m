From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 30 May 2014 09:55:10 +0200
Subject: [PATCH] ahci: imx: manage only sata_ref_clk in
 imx_sata_enable[disable]
In-Reply-To: <CAOMZO5Az_JR58a3cwGYK1_vcJ_twz4sEq+NHXv2SZ6yuN=wjGQ@mail.gmail.com>
References: <1401289539-3485-1-git-send-email-shawn.guo@freescale.com>	<5386026C.1010603@redhat.com>	<CAOMZO5BkdkU-_s8G5CqVMzfkMgxdUg8bx0JJnqC8dPyFMK=Ocw@mail.gmail.com>	<538610D5.7070908@redhat.com>
 <CAOMZO5Az_JR58a3cwGYK1_vcJ_twz4sEq+NHXv2SZ6yuN=wjGQ@mail.gmail.com>
Message-ID: <5388395E.80500@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/28/2014 06:48 PM, Fabio Estevam wrote:
> On Wed, May 28, 2014 at 1:37 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Ah yes I see, the ahci_imx suspend/resume handler now no longer
>> touches the controller, but the ata core is still trying to use it.
>>
>> Ok, in that case I agree that your original patch is the best
>> solution.
>>
>> Your original patch is:
>>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> I think you meant Shawn's patch, not mine :-)

Right, so to be extra clear, the patch titled:

"ahci: imx: manage only sata_ref_clk in imx_sata_enable[disable]"

is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
