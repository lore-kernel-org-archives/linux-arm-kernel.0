From: kyle@redhat.com (Kyle McMartin)
Date: Thu, 16 Jan 2014 14:28:42 -0500
Subject: [PATCH] aarch64: always map VDSO at worst case alignment
In-Reply-To: <20140116175318.GK18705@redacted.bos.redhat.com>
References: <20140115214144.GF18705@redacted.bos.redhat.com>
 <20140116174344.GJ30257@mudshark.cambridge.arm.com>
 <20140116175318.GK18705@redacted.bos.redhat.com>
Message-ID: <20140116192841.GN18705@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 12:53:18PM -0500, Kyle McMartin wrote:
> I'll reboot a machine with this fix to test it as soon as possible.
> 
> Acked-by: Kyle McMartin <kyle@redhat.com>
> 

Yeah, looks to work properly, although I didn't test 64K pages in the
simulator.

--Kyle
