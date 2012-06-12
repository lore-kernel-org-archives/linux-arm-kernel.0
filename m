From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 12 Jun 2012 10:49:34 -0700
Subject: [PATCH v2] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <4FD780D2.603@zytor.com>
References: <1339470307-28223-1-git-send-email-tmac@hp.com>
 <20120612191804.4211462a@tukaani.org>
 <alpine.LFD.2.02.1206121316190.23555@xanadu.home>
 <4FD77CAF.1020402@zytor.com>
 <alpine.LFD.2.02.1206121336060.23555@xanadu.home> <4FD780D2.603@zytor.com>
Message-ID: <4FD7812E.2090400@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2012 10:48 AM, H. Peter Anvin wrote:
> 
> The point is that I think we pretty much end up with a null usable set
> in the end.
> 

s/usable/useful/

	-hpa
