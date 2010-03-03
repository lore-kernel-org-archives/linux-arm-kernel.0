From: swetland@google.com (Brian Swetland)
Date: Wed, 3 Mar 2010 14:27:31 -0800
Subject: board/device file names, and machine names
In-Reply-To: <alpine.LFD.2.00.1003031651400.31128@xanadu.home>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<20100302235137.GC29715@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003031651400.31128@xanadu.home>
Message-ID: <a55d774e1003031427scf8b2ebp8b57a22bd89b9beb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 3, 2010 at 2:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> IMHO using the internal name in the code is the most sensible thing to
> do. ?Why? Because marketing people are a very emotional and influential
> bunch, and they often change their mind about naming and (re)branding.
>
> Been there already. ?And it also happened that marketing people just
> asked of us developers that the name of the files and functions in the
> source tree be changed to the marketing name du jour. ?They especially
> don't want customers to ever notice that the new product out of the shop
> with all those revolutionary features and performances is in fact
> (technically speaking) just a minor revision of the previous product
> which can be supported by the same code as the previous product. ?This
> has to be pushed back of course.

This is a big motivation behind our "fish" names for boards -- they're
pretty unappetizing to the pr/marketing folks so they never get mixed
up with final product names and we can concentrate on making the
hardware work.  We can register board IDs far in advance and avoid
using "fake" machine IDs, yet not freak anybody out by revealing
significant product details.  Also, unlike numeric board names, they
tend to not imply one being better than the other, etc.

Brian
