From: geoff@infradead.org (Geoff Levand)
Date: Wed, 26 Oct 2016 12:57:52 -0700
Subject: [PATCH] arm64: Add support of R_AARCH64_PREL32 relocation in
 purgatory
In-Reply-To: <0eb8a908f617e0f957df7fb3ef293596f47e6832.1477456661.git.panand@redhat.com>
References: <0eb8a908f617e0f957df7fb3ef293596f47e6832.1477456661.git.panand@redhat.com>
Message-ID: <34a7177f-3bd8-8ccf-f928-36f89e9e29f2@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2016 09:40 PM, Pratyush Anand wrote:
> +	case R_AARCH64_PREL32:
> +		type = "PREL32";
> +		loc32 = ptr;
> +		*loc32 = cpu_to_elf32(ehdr, elf32_to_cpu(ehdr, *loc32) + value - address);

Please keep line width less than 80 chars.

> +		break;
