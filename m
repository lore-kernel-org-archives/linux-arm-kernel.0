From: jgross@suse.com (Juergen Gross)
Date: Tue, 2 May 2017 12:13:40 +0200
Subject: [PATCH 0/3 v2] xen: Implement EFI reset_system callback
In-Reply-To: <20170424175839.5262-1-julien.grall@arm.com>
References: <20170424175839.5262-1-julien.grall@arm.com>
Message-ID: <aa878a86-42c9-7017-5f8d-71fff848c20b@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/17 19:58, Julien Grall wrote:
> Hi all,
> 
> This small patch series implements EFI reset_system callback when using EFI
> Xen. Without this, it will not be possible to reboot/power off ARM64 DOM0
> when using ACPI.
> 
> Cheers,
> 
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>

Series rebased and pushed to xen/tip for-linus-4.12b


Juergen
