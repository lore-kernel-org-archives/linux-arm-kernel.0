From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Fri, 17 Feb 2017 22:56:11 +0100
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
In-Reply-To: <20170217154419.xr4n2ikp4li3c7co@lukather>
References: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
 <CACvgo51p+aqegjkbF6jGggwr+KXq_71w0VFzJvFAF6_egT1-kA@mail.gmail.com>
 <20170217154419.xr4n2ikp4li3c7co@lukather>
Message-ID: <20170217215611.2ft4rpnukbijcgqn@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 04:44:19PM +0100, Maxime Ripard wrote:
[...]
> We already have DT bindings for out of tree drivers, there's really
> nothing new here.

We have DT bindings for *hardware*, not for drivers. As stated in
Documentation/devicetree/usage-model.txt:

"The "Open Firmware Device Tree", or simply Device Tree (DT), is a data
structure and language for describing hardware.  More specifically, it
is a description of hardware that is readable by an operating system
so that the operating system doesn't need to hard code details of the
machine."

"2.1 High Level View
-------------------
The most important thing to understand is that the DT is simply a data
structure that describes the hardware."

-- 
Rask Ingemann Lambertsen
