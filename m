From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 15 Feb 2014 11:23:25 -0800
Subject: [PATCH v5 1/6] spmi: Linux driver framework for SPMI
In-Reply-To: <1391468739-20987-2-git-send-email-joshc@codeaurora.org>
References: <1391468739-20987-1-git-send-email-joshc@codeaurora.org>
 <1391468739-20987-2-git-send-email-joshc@codeaurora.org>
Message-ID: <20140215192325.GB2280@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 05:05:33PM -0600, Josh Cartwright wrote:
> From: Kenneth Heitke <kheitke@codeaurora.org>
> 
> System Power Management Interface (SPMI) is a specification
> developed by the MIPI (Mobile Industry Process Interface) Alliance
> optimized for the real time control of Power Management ICs (PMIC).
> 
> SPMI is a two-wire serial interface that supports up to 4 master
> devices and up to 16 logical slaves.
> 
> The framework supports message APIs, multiple busses (1 controller
> per bus) and multiple clients/slave devices per controller.
> 
> Signed-off-by: Kenneth Heitke <kheitke@codeaurora.org>
> Signed-off-by: Michael Bohan <mbohan@codeaurora.org>
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>

Looks good, nice bus code.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
