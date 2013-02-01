From: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 31 Jan 2013 22:37:16 -0800
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <alpine.LFD.2.02.1301312117240.6300@xanadu.home>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
 <20130129101549.GP23505@n2100.arm.linux.org.uk> <51089523.3080804@zytor.com>
 <alpine.LFD.2.02.1301301326530.6300@xanadu.home> <510AE6BF.4080303@zytor.com>
 <alpine.LFD.2.02.1301311700470.6300@xanadu.home> <510AEDC2.80107@zytor.com>
 <alpine.LFD.2.02.1301312117240.6300@xanadu.home>
Message-ID: <510B629C.1010605@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2013 06:28 PM, Nicolas Pitre wrote:
>>
>> Well, it is too nasty for public confession, but it's called
>> "paravirtualization".
> 
> The fact that you are aware of it means we're not going to break them.  
> 
> But my point is that we must not be held back just in case someone out 
> there might have painted himself in a corner without telling anyone.
> 

Yes.  However, it makes it more questionable to simply rip out
compression methods without warning.  Not that warnings help, as we have
learned.

	-hpa
