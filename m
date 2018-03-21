From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 21 Mar 2018 10:18:13 +0800
Subject: [PATCH 2/7] dt-bindings: add binding for the Allwinner A64 DE2 bus
In-Reply-To: <20180320184646.dynqv6qubzabroe4@flea>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180316175354.21437-3-icenowy@aosc.io>
 <20180320184646.dynqv6qubzabroe4@flea>
Message-ID: <AAC74653-C6EB-4BE3-BB19-210687C1E158@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?3?21? GMT+08:00 ??2:46:46, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Sat, Mar 17, 2018 at 01:53:49AM +0800, Icenowy Zheng wrote:
>> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64 SoC
>to
>> be claimed, otherwise the whole DE2 space is inaccessible.
>> 
>> Add a device tree binding of the DE2 part as a sub-bus.
>
>Where did you get the info that it was a bus?

There's no direct evidence, just some guess.

The DE2 is a whole part that is just allocated a memory
space at the user manual, and the SRAM controls the
access to all modules in the DE2.

So it might be a bus.

Implement it as a bus is a clear representation on A64.

>
>Maxime
