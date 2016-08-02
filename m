From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Wed, 3 Aug 2016 00:08:09 +0900
Subject: [PATCH 0001/1285] Replace numeric parameter like 0444 with macro
In-Reply-To: <20160802141503.1e8d8796@lxorguk.ukuu.org.uk>
References: <20160802103322.13810-1-baolex.ni@intel.com>
 <20160802141503.1e8d8796@lxorguk.ukuu.org.uk>
Message-ID: <20160803000809.2cf4f06d9e977c8cf06244a2@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Aug 2016 14:15:03 +0100
One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> wrote:

> On Tue,  2 Aug 2016 18:33:22 +0800
> Baole Ni <baolex.ni@intel.com> wrote:
> 
> > I find that the developers often just specified the numeric value
> > when calling a macro which is defined with a parameter for access permission.
> > As we know, these numeric value for access permission have had the corresponding macro,
> > and that using macro can improve the robustness and readability of the code,
> > thus, I suggest replacing the numeric parameter with the macro.
> 
> If you are going to do this then please generate one patch per subsystem,
> and just do a couple of subsystems initially until everyone is happy with
> how it is being converted, then send out more subsystem by subsystem.

+1

Moreover, please DO NOT use same subject and same description for each patch (explain
what you did and why for each one), unless it will be just spamming git-log...

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
