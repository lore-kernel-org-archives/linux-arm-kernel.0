From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 27 Oct 2015 09:44:30 -0500
Subject: [PATCH v4 3/3] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <CAKv+Gu-G1YS9Ha=-rtnPKJTOxBTrdSq6=Tqwq_GPW742JUE+2Q@mail.gmail.com>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
 <562EA894.8070505@arm.com> <562EAA22.3010905@arm.com>
 <CAKv+Gu-G1YS9Ha=-rtnPKJTOxBTrdSq6=Tqwq_GPW742JUE+2Q@mail.gmail.com>
Message-ID: <562F8DCE.4010308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2015 09:20 PM, Ard Biesheuvel wrote:
> Thanks for the report. The following patch should fix it

Ard,
	
Thanks, it does fix the build problem...

Now to get the darn thing to boot (not related to this AFAIK).



	
