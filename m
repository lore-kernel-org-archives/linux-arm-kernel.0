From: JBeulich@suse.com (Jan Beulich)
Date: Mon, 23 Nov 2015 04:37:44 -0700
Subject: [Xen-devel] [PATCH v3 06/62] acpi: Refactor
 acpi_os_map_memory to be architecturally independent
In-Reply-To: <alpine.DEB.2.02.1511231128160.1107@kaball.uk.xensource.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-7-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511231128160.1107@kaball.uk.xensource.com>
Message-ID: <5653089802000078000B7C2B@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 23.11.15 at 12:29, <stefano.stabellini@eu.citrix.com> wrote:
> On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>> Current acpi_os_map_memory is specific to x86. Refactor it to be
>> architecturally independent.
> 
> I would say "Move it to an x86-specific location".

But it shouldn't be moved - only the _truly_ x86-specific pieces should
be factored out.

Jan
