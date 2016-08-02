From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 2 Aug 2016 14:15:03 +0100
Subject: [PATCH 0001/1285] Replace numeric parameter like 0444 with macro
In-Reply-To: <20160802103322.13810-1-baolex.ni@intel.com>
References: <20160802103322.13810-1-baolex.ni@intel.com>
Message-ID: <20160802141503.1e8d8796@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  2 Aug 2016 18:33:22 +0800
Baole Ni <baolex.ni@intel.com> wrote:

> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.

If you are going to do this then please generate one patch per subsystem,
and just do a couple of subsystems initially until everyone is happy with
how it is being converted, then send out more subsystem by subsystem.

Alan
