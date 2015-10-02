From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Oct 2015 15:49:39 +0100
Subject: [PATCH net-next] ARM: net: support BPF_ALU | BPF_MOD
 instructions in the BPF JIT.
In-Reply-To: <1443796671-12598-1-git-send-email-nschichan@freebox.fr>
References: <1443796671-12598-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20151002144939.GZ21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 04:37:51PM +0200, Nicolas Schichan wrote:
> @@ -125,7 +125,7 @@ static u64 jit_get_skb_w(struct sk_buff *skb, int offset)
>  }
>  
>  /*
> - * Wrapper that handles both OABI and EABI and assures Thumb2 interworking
> + * Wrappers that handles both OABI and EABI and assures Thumb2 interworking

That doesn't read right with "wrapper" becoming plural.

"Wrapper that handles ..."

or

"Wrappers which handle ..."

As normal, I'll let David pick the patch up, but please adjust the above
comment first, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
