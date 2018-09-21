From: oneukum@suse.com (Oliver Neukum)
Date: Fri, 21 Sep 2018 10:08:24 +0200
Subject: Kernel memory leak on CDC-ACM device plug/unplug
In-Reply-To: <CAGkQfmP6o+e_nanviTfRt7Ej9U+4BdqDYvMM83FjHhSCECcH3w@mail.gmail.com>
References: <CAGkQfmP6o+e_nanviTfRt7Ej9U+4BdqDYvMM83FjHhSCECcH3w@mail.gmail.com>
Message-ID: <1537517304.15252.0.camel@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mi, 2018-09-19 at 16:11 +0200, Romain Izard wrote:
> While trying to debug a memory leak problem, I encountered the following
> problem:
> 
> After plugging/unplugging an USB CDC-ACM device, kmemleak reports multiple
> copies of the following leak. It is not necessary to open the port for the
> leak to happen.

Hi,

nothing is immediately obvious to me. Could you compile a kernel with
CONFIG_DEBUG_KMEMLEAK?

	Regards
		Oliver
