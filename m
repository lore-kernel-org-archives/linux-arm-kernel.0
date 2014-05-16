From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 May 2014 09:57:48 +0100
Subject: [PATCH v2 09/11] arm64/crypto: add voluntary preemption to
 Crypto Extensions SHA1
In-Reply-To: <CAKv+Gu_Tupu8jJX+6hRx_LOM0y05A5+MPXndzSKRNYQcG-yAvw@mail.gmail.com>
References: <1400091451-9117-1-git-send-email-ard.biesheuvel@linaro.org>
 <1400091451-9117-10-git-send-email-ard.biesheuvel@linaro.org>
 <20140515172458.GE1499@arm.com>
 <CAKv+Gu-9P+vDPnvr2Cz4Bcw5=5SuEMw-xFxLM4=SoF65ESvhcQ@mail.gmail.com>
 <E28B9BA9-468D-45BD-A479-5D9289616798@arm.com>
 <CAKv+Gu_Tupu8jJX+6hRx_LOM0y05A5+MPXndzSKRNYQcG-yAvw@mail.gmail.com>
Message-ID: <20140516085748.GD5624@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 11:10:20PM +0100, Ard Biesheuvel wrote:
> On 15 May 2014 14:47, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > For the time being I would drop the last 4 patches. We can revisit them
> > for the next kernel version.
> 
> Agreed.
> 
> Should I send an updated pull request?

As it's not a signed tag anyway, I can merge up to the relevant commit.

-- 
Catalin
