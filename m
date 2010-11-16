From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Nov 2010 13:39:18 -0800
Subject: [PATCHv3 1/1] omap: Ptr "isr_reg" tracked as NULL was dereferenced
In-Reply-To: <cd6fa21776a4564d602cc072358a4bf79a9fe883.1289205105.git.EXT-Eugeny.Kuznetsov@nokia.com>
References: <cd6fa21776a4564d602cc072358a4bf79a9fe883.1289205105.git.EXT-Eugeny.Kuznetsov@nokia.com>
Message-ID: <20101116213918.GN9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com> [101108 00:35]:
> From: Evgeny Kuznetsov <ext-eugeny.kuznetsov@nokia.com>
> 
> Value of "isr_reg" pointer is depend on configuration and GPIO method.
> Potentially it may have NULL value and it is dereferenced later
> in code. Warning and exit from function are added in this case.

Thanks, queueing this for 2.6.38 merge window.

Tony
