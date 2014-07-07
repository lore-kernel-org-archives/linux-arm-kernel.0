From: tinamdar@apm.com (Tanmay Inamdar)
Date: Mon, 7 Jul 2014 11:26:43 -0700
Subject: [PATCH] arm64: PCI(e) arch support
In-Reply-To: <53B5F81B.8010801@freescale.com>
References: <1404422876-1160-1-git-send-email-tinamdar@apm.com>
 <53B5F81B.8010801@freescale.com>
Message-ID: <CACoXjc=0+gkHCX7SkcVrJ6xGNyVLyW-X+ZfDzJwSDn-9QX5zkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 3, 2014 at 5:40 PM, Prabhakar Kushwaha
<prabhakar@freescale.com> wrote:
> Hi Tanmay, Liviu,
>
> On 7/4/2014 2:57 AM, Tanmay Inamdar wrote:
>>
>> Reposting on request of several people since previously posted one was
>> corrupted.
>>
>> This patch adds the arch support for PCI(e) for arm64. The files
>> added or modified in this patch are based on PCI(e) support in
>> 32bit arm.
>>
>> Please note that this patch is just for the reference. Liviu Dudau from
>> ARM
>> has posted his v8 series of patch to support PCIe in arm64.
>>
>> The patch will apply against 3.13 Linux Kernel
>>
>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>>
>
> do we foresee similar type of changes in u-boot  to support PCI(e) for
> ARM64.
>

Well.. Actually PCI(e) has no dependency on ARM64 architecture. This
patch is required only because of current Linux structure. Hence
Liviu's effort to take PCI(e) out of 'arch' makes sense.

In my experience, I don't think any arch specific changes are required
in u-boot. At least I don't recall making any specific changes in
u-boot pci layer. However we don't really have a big use case for PCIe
in u-boot. It just links up and lists the devices discovered during
enumeration.


> Regards,
> Prabhakar
>
>
