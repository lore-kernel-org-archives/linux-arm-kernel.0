From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 19 Jan 2010 09:33:48 -0800
Subject: [RFC 18/18] arm: mm: qsd8x50: Fix incorrect permission faults
In-Reply-To: <20100119171033.GA1323@shareable.org>
References: <20100119171033.GA1323@shareable.org>
Message-ID: <1263922428.1951.63.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-19 at 17:10 +0000, Jamie Lokier wrote:

> Notably:
> 
> +Redistributions in source form must retain the above copyright notice, this
> +list of conditions and the following disclaimer as the first lines of this
> +file unmodified.
> 
> So nobody can add a title to the documentation, add another copyright
> year and name, convert it to Docbook, etc....?

Everything I release will ultimately be licensed under the GPLv2
regardless of the license in the current files.. So it's just a matter
of removing that old license ..

> For another file, I'm not sure that adding "All rights reserved" is ok.
> Under the GPL, all rights are _not_ reserved:

This would be a problem because our lawyers mandate this.. AFAIK, it
doesn't change the licensing tho.

Daniel
