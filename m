From: trini@ti.com (Tom Rini)
Date: Thu, 21 Feb 2013 12:40:01 -0500
Subject: [U-Boot] [RFC] Kbuild support for ARM FIT images
In-Reply-To: <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
Message-ID: <51265BF1.5000302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/21/2013 12:25 PM, Nicolas Pitre wrote:
> On Thu, 21 Feb 2013, Tom Rini wrote:
[snip]
>>> uboot dug _itself_ into this hole.  It's uboot's problem.
>> 
>> A whole lot  of people dug this particular hole.  Joel is trying
>> to offer up a solution that maybe makes things easier for
>> everyone.  Or it gets rejected here too and distros will come up
>> with their N different ways to try and provide easier experiences
>> to the end user.
> 
> Nothing being perfect, it is probably unreasonable to think that
> every board will start shipping with complete and correct DT
> description, etc. But so is the state of FIT support right now.
> That solution to make things easier for everyone should actually
> make that DT vs kernel separation more effective and provide better
> mechanisms for gluing the various DTBs to their respective boards,
> and not to glue them to the kernel to populate a distro filesystem
> with them.

I very much agree here.  And in the end, what I really really want to
avoid is every distribution (or similar grouping of stuff) coming up
with N different ways to solve the problem of "how do I get the user
the right device tree to go with $whatever board they happen to be
running".  If the clever solution everyone comes up with is some other
container that's not FIT, that's fine, patches welcome and happily
reviewed for whatever the solution is.  I just don't want people
thinking this is a problem that hasn't been thought of before.

- -- 
Tom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRJlvxAAoJENk4IS6UOR1W92YQAJZkRAllCkYqUr9sopAxElwV
lyuv7GJ2NHT9E39jS0muWk9+t104a0iIQY71Va0UgxFt2lATW9HwffHG3nORK/qF
H7lgzfRGgHUjxkZk5D1jlJI6B6mdWtGcC3aN8f6NVZ2wVH7jxDWoi2hxiP68P/in
xBNNpHmhwuBwUZ9o1A1W+0rGP8/qOIW/q8GVRLtO2Dw94fEKiWUF6V5VBsIFdeuO
Vg3p4vuuvaaF0i1cPlZQAvfykvPoGF6UB1s5MdsuHxTEuRoQa5UdakcwFRnN5I/C
pXdK8m4JtJQt4cDj4Jq4FogPzkdbI8VkJ1/8fYpjWnhn1DSawsMinVODRQ+9cy4u
aR0t901gQPu13HKqlTZ4kViAhSCGcoVxzzDCpQm3P2YuaLvJJX/uS4eFo8HAX+Jl
KfGsf4EXFtRygJtCng4TDdS4WYp6L0VtJVzx4cEzO6syEO5Kz7KgC6SRcfI1pNfm
u5RQarknuSJBTW7x5yBYpMu1Zypl3wEqQxaroF8MtQV3qE4bQpwhtljc8h4huVZ0
sMdyAeS9T4gkVp4+H553n8nHrbDCcIdutaCRrcIVDY0dldE/CITpagthK6znMCoP
YHHzCkoG+M+9wSueE5GNWvxmWwL3dUYBest/rfa/Eqx5H0o1aSyGyjZeSM9IgnZo
YCtEaoq6gT2VDTIl7tCK
=vnlO
-----END PGP SIGNATURE-----
