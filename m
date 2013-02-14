From: nschichan@freebox.fr (Nicolas Schichan)
Date: Thu, 14 Feb 2013 14:40:09 +0100
Subject: [PATCH] ARM: net: bpf_jit: fix emit_swap16() for non ARMv6+.
In-Reply-To: <511C0662.8010309@gmail.com>
References: <1360776125-14542-1-git-send-email-nschichan@freebox.fr>
 <1360776645-14726-1-git-send-email-nschichan@freebox.fr>
 <511C0662.8010309@gmail.com>
Message-ID: <511CE939.5000705@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2013 10:32 PM, Mircea Gherzan wrote:
[...]
> Acked-by: Mircea Gherzan <mgherzan@gmail.com>

Hi,

Thanks Mircea. Russel, David, do you have any preference as to which path this 
patch should take (net tree or ARM tree) ?

Regards,

-- 
Nicolas Schichan
Freebox SAS
