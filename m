From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Wed, 17 May 2017 09:30:46 +0000
Subject: [PATCH] powerpc: booke: fix boot crash due to null hugepd
In-Reply-To: <20170517091547.GB17902@kroah.com>
References: <20170516144752.8444-1-laurentiu.tudor@nxp.com>
 <20170517091547.GB17902@kroah.com>
Message-ID: <591C1845.7040105@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 05/17/2017 12:15 PM, Greg KH wrote:
> On Tue, May 16, 2017 at 09:47:52AM -0500, laurentiu.tudor at nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> On 32-bit book-e machines, hugepd_ok() does not take
>> into account null hugepd values, causing this crash at boot:
>>
>
> $ ./scripts/get_maintainer.pl --file arch/powerpc/include/asm/nohash/pgtable.h
> Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
> Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
> Michael Ellerman <mpe@ellerman.id.au> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT),commit_signer:2/3=67%)
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> (commit_signer:2/3=67%,authored:1/3=33%,added_lines:3/8=38%,removed_lines:2/3=67%)
> Scott Wood <oss@buserror.net> (commit_signer:1/3=33%)
> Laurentiu Tudor <laurentiu.tudor@nxp.com> (commit_signer:1/3=33%,authored:1/3=33%,added_lines:1/8=12%,removed_lines:1/3=33%)
> Christophe Leroy <christophe.leroy@c-s.fr> (commit_signer:1/3=33%,authored:1/3=33%,added_lines:4/8=50%)
> linuxppc-dev at lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT))
> linux-kernel at vger.kernel.org (open list)
>
> I'm not listed there at all, any specific reason you sent this to me?
> Nothing I can do with it...
>

Just some finger trouble on my side. Please disregard and sorry for the 
noise.

---
Best Regards, Laurentiu
