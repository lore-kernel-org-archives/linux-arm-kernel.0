From: dhowells@redhat.com (David Howells)
Date: Wed, 11 Jan 2017 15:29:24 +0000
Subject: [PATCH 8/8] efi: Add EFI_SECURE_BOOT bit [ver #6]
In-Reply-To: <20170111145138.GB29649@codeblueprint.co.uk>
References: <20170111145138.GB29649@codeblueprint.co.uk>
 <148120020832.5854.5448601415491330495.stgit@warthog.procyon.org.uk>
 <148120026820.5854.13036556358308461345.stgit@warthog.procyon.org.uk>
Message-ID: <7979.1484148564@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt Fleming <matt@codeblueprint.co.uk> wrote:

> Before we add more efi.flags bits I'd like this series to include the
> patch that makes use of EFI_SECURE_BOOT. Alternatively, you move this
> last patch to a new series.

Are you willing to take the kernel lock-down patches also?

David
