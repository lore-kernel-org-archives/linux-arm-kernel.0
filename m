From: nschichan@freebox.fr (Nicolas Schichan)
Date: Tue, 25 Aug 2015 15:17:41 +0200
Subject: Prevent list poison values from being mapped by userspace
 processes
In-Reply-To: <20150825081556.GL7557@n2100.arm.linux.org.uk>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk> <55DB16AF.7090607@freebox.fr>
 <20150825081556.GL7557@n2100.arm.linux.org.uk>
Message-ID: <55DC6AF5.1090306@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2015 10:15 AM, Russell King - ARM Linux wrote:
>> Also, when CONFIG_CPU_SW_DOMAIN_PAN is not set, the DACR_INIT constant is
>> setup with (domain_val(DOMAIN_USER, DOMAIN_NOACCESS) which will cause the
>> kernel to die with a "page domain fault" when running init.
> 
> If you don't mind, I'll merge that into the patch adding this so it
> doesn't introduce a regression there.
> 
> Once I've fixed the abort handler issue, would you mind re-testing
> and giving a tested-by attributation please?

Sure, I've got no problem with that and I'll be happy to re-test.

-- 
Nicolas Schichan
