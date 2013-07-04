From: zonque@gmail.com (Daniel Mack)
Date: Thu, 04 Jul 2013 19:57:53 +0200
Subject: Appended DTB files for multi-machine kernels
In-Reply-To: <alpine.LFD.2.03.1307041322070.18597@syhkavp.arg>
References: <51D5A938.30607@gmail.com>
 <alpine.LFD.2.03.1307041322070.18597@syhkavp.arg>
Message-ID: <51D5B7A1.60609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On 04.07.2013 19:28, Nicolas Pitre wrote:
> On Thu, 4 Jul 2013, Daniel Mack wrote:
>> I'm open to opinion and sugesstions :)
> 
> What you describe above more or less fits the definition of what I 
> called the "impedance matcher".  However it doesn't need to be part of 
> the kernel at all.  But you should make it into a separate binary.
> 
> Please have a look at the bottom of this post for a more comprehensive 
> description: http://article.gmane.org/gmane.linux.ports.arm.kernel/242929

Thanks for the link. Interesting read indeed.

The only thing I'm pondering about is that we already have generic
loader code in Linux and a build system that supports a wide range of
platforms. I don't know whether it's worth opening that can of worms
again and re-implement all details about load addresses, compiler flags,
device-tree parsing code yet once again. At least in terms of LOCs, we
would certainly be better off doing it inside the kernel.

But I generally second your opinion about pushing vendors to do it
right, so I might give that approach a shot soon; there is no code yet
anywhere I take it?


Thanks,
Daniel
