From: JBeulich@suse.com (Jan Beulich)
Date: Tue, 17 Nov 2015 04:07:48 -0700
Subject: [PATCH v3 50/62] xen/efi: store EFI system table in efi structure
In-Reply-To: <1447753261-7552-51-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-51-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B189402000078000B5D47@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> When preparing EFI tables for Dom0, it needs the information of EFI
> system table. Here store it in efi structure.

Again I'm pretty sure I had already pointed out that this not being
needed on x86 calls for either more than the brief description above
or this being done just for ARM or (preferably) the table pointer
- where _really_ needed - to be passed around as function
argument(s).

Jan
