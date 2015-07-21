From: rjui@broadcom.com (Ray Jui)
Date: Tue, 21 Jul 2015 14:04:33 -0700
Subject: [PATCH v3 1/4] PCI: iproc: enable arm64 support for iProc PCIe
In-Reply-To: <55AEB094.1090601@broadcom.com>
References: <1437021563-29139-1-git-send-email-rjui@broadcom.com>
 <1437021563-29139-2-git-send-email-rjui@broadcom.com>
 <20150721203018.GH21967@google.com> <55AEB094.1090601@broadcom.com>
Message-ID: <55AEB3E1.6010405@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/21/2015 1:50 PM, Ray Jui wrote:
> 
> 
> On 7/21/2015 1:30 PM, Bjorn Helgaas wrote:
>> On Wed, Jul 15, 2015 at 09:39:20PM -0700, Ray Jui wrote:

>> I see that your v1 patch added #ifdef CONFIG_ARM around sysdata at its
>> original location below, and you mentioned that you took Arnd's advice to
>> move sysdata to the beginning of the structure, but I don't see Arnd's
>> email on the list.
>>
> 
> Sorry maybe you need to elaborate here. Am I supposed to add Arnd's name
> in the commit message? Other than that, Arnd is on this email thread.
> 

For your previous question: when Arnd replied, he only replied to me but
did not reply to all, that's why you cannot find his email....

Ray
