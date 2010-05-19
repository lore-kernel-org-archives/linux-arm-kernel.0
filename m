From: wmb@firmworks.com (Mitch Bradley)
Date: Tue, 18 May 2010 21:25:38 -1000
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1005180802010.12758@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>	<201005181324.45701.jeremy.kerr@canonical.com>	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
Message-ID: <4BF39272.7070909@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> ...
> Exact.  For example, on ARM the machine ID is also used to figure out 
> the MMU mapping needed to be able to simply be able to debug the very 
> early assembly boot stage when there isn't even a stack available. While 
> this info is stored in the machine record, it is actually 
> subarchitecture specific and already half-digested for easy usage by 
> that initial MMU setup.  I just don't want to imagine what the 
> equivalent functionality with DT would look like.
>
>
>   

Under what circumstances would the Linux startup code not have a stack - 
or not be able to set up one easily?
