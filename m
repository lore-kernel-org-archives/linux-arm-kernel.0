From: trd@45mercystreet.com (Toby Douglass)
Date: Mon, 23 Nov 2009 21:34:33 +0100
Subject: CAS implementation may be broken
In-Reply-To: <20091123200620.GF18142@n2100.arm.linux.org.uk>
References: <4AF1C361.8090405@45mercystreet.com>
	<20091104190544.GA518@n2100.arm.linux.org.uk>
	<4AF1FBA4.4070307@xenomai.org> <4B08055C.3000408@45mercystreet.com>
	<20091123150842.GD18142@n2100.arm.linux.org.uk>
	<4B0ADE3B.3040307@45mercystreet.com>
	<20091123200620.GF18142@n2100.arm.linux.org.uk>
Message-ID: <4B0AF1D9.3030008@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Nov 23, 2009 at 08:10:51PM +0100, Toby Douglass wrote:
>> This was the thrust of the original post; however, Catalin has raised  
>> arguments against it which I have not yet digested, so what I'm writing  
>> here, where it is simply an enlargement on the OP, has the same flaws;  
>> it's only in response to your specific point.  I'm not trying to assert  
>> this *is* what happens, in spite of what Catalin has written.
> 
> Well, I've thought it through quite a bit now, and I have an expansive
> reply to your email.  In summary, there is nothing wrong with the
> existing code; your use of it is the problem.
> 
> I can post the expansive reply if you need the details.

I would be very grateful if you could - although if it is extensive and 
well-understood, you might want to spare the list and email me directly.

I've been working every hour there is for the last three weekends trying 
to get CAS working properly on ARM under Linux; any fresh insight or 
knowledge from others may give me what I need to work out what I've 
mis-understood (before I go insane :-)

> In short, consider what happens if you consider a slightly different order
> of operations, where you have calculated 'ptr', 'old' and 'new' for cmpxchg
> but you haven't executed the first ldrex.

This is, I think, what Catalin said - I'm grappling with this at the 
moment; I don't have a reply to it yet, positive or negative.
