From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 5 Oct 2010 17:16:02 +0900
Subject: [PATCH 7/7] sh: Annotate oprofile_arch_exit() with __exit marker
In-Reply-To: <4426d17460dc88dcb3d6e3af1b91af4db83785ae.1286222593.git.matt@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<4426d17460dc88dcb3d6e3af1b91af4db83785ae.1286222593.git.matt@console-pimps.org>
Message-ID: <20101005081602.GD7984@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 09:44:25PM +0100, Matt Fleming wrote:
> In order to avoid a section mismatch we need to annotate
> oprofile_arch_exit() with an __exit marker.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

For general completeness:

Acked-by: Paul Mundt <lethal@linux-sh.org>
