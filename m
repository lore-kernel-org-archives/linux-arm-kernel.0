From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 26 Mar 2013 21:02:07 +0000
Subject: [PATCHv2 4/4] arm: orion5x: correct IRQ used in dtsi for mv_cesa
In-Reply-To: <20130325084739.GF5627@lunn.ch>
References: <1364077797-21206-1-git-send-email-alex@digriz.org.uk>
 <1364077797-21206-5-git-send-email-alex@digriz.org.uk>
 <20130325084739.GF5627@lunn.ch>
Message-ID: <20130326210207.GN7123@edkhil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 25, 2013 at 09:47:39AM +0100, Andrew Lunn wrote:
>On Sat, Mar 23, 2013 at 10:29:57PM +0000, Alexander Clouter wrote:
>> The crypto functionality hook in the orion5x dtsi uses an IRQ that clashes
>> with the Ethernet controller, so lets move it to use the IRQ that the non-DT
>> code utilises.
>
>Move is the wrong word here. The IRQ are hardware assigned, you cannot
>pick and choose. I would write a comment like:
>
>Fix the IRQ number for crypto, which should be 28, not 22 which is
>actually Ethernet.
>
No problem, wanging an updated patch out.

Cheers

-- 
Alexander Clouter
.sigmonster says: BOFH excuse #125:
                   we just switched to Sprint.
