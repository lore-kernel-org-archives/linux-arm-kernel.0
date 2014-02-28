From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 28 Feb 2014 10:17:43 -0600
Subject: [PATCH 3/5] documentation/iommu: update description of ARM System
 MMU binding
In-Reply-To: <1393002992-24561-4-git-send-email-will.deacon@arm.com>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
 <1393002992-24561-4-git-send-email-will.deacon@arm.com>
Message-ID: <CAOZdJXUfAygZqw9s5qOECLjyo=B0VaD29iesbWzDeMbbyVTgqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 11:16 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> +- calxeda,smmu-secure-config-access : Enable proper handling of buggy
> +                  implementations that always use secure access to
> +                  SMMU configuration registers. In this case non-secure
> +                 aliases of secure registers have to be used during
> +                 SMMU configuration.

I'm confused.  Why does this property have a "calxeda" prefix?  How is
it a Calxeda-specific property?
