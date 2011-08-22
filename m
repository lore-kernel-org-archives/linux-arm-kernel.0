From: koen@beagleboard.org (Koen Kooi)
Date: Mon, 22 Aug 2011 18:15:23 +0200
Subject: Passing camera module type using "camera" argument.
In-Reply-To: <CACKLOr1m9EgzO-P+4yPVVj6tNgmOFPS4_LJAxOY03H73oLHqqg@mail.gmail.com>
References: <CACKLOr03ZzpytdYrnk-bJv2A7sbTTa_y_Dj+JspyiYJKgX8wog@mail.gmail.com>
	<28378F63-781A-412C-A18A-5007E48A98A3@beagleboard.org>
	<CACKLOr1m9EgzO-P+4yPVVj6tNgmOFPS4_LJAxOY03H73oLHqqg@mail.gmail.com>
Message-ID: <15E409B0-1DC8-4139-8757-6C5593396E36@beagleboard.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 22 aug. 2011, om 08:42 heeft javier Martin het volgende geschreven:

> 
> Hi Koen,
> 
> On 19 August 2011 17:07, Koen Kooi <koen@beagleboard.org> wrote:
> 
> 
> Op 19 aug. 2011 om 14:39 heeft javier Martin <javier.martin@vista-silicon.com> het volgende geschreven:
> 
>> Hi,
>> I've been digging into the code of linux-omap kernel in Angstrom for Beagleboard and I've noticed there is an argument called "camera" which can be passed to the kernel. This allows telling the linux kernel what camera module is actually connected to the platform.
>> 
>> However, when I look the mainline kernel 3.0 I see those changed have not yet made into it. Is this mechanism accepted by the community?
> 
> When I asked a few months ago the consensus was that there currently is no better way. DT might solve it, but that's still some time away
> 
> So, as I understand, using a command line argument for this purpose is the preferred way by the community but, at the same time, they won't accept patches that implement this approach.

>From what I understood a patch doing that wouldn't be rejected, but Laurent/Tony would have to chime in to confirm that.
