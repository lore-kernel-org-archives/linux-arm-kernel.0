From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Apr 2013 13:43:01 -0700
Subject: [PATCH V7 2/2] ARM: bcm281xx: Add timer driver (DT portion)
In-Reply-To: <CAGFynZ_YEHbUQxGFgp_SA__4xRge64oQ-y5ypXhV5mhtM2k4+w@mail.gmail.com>
References: <1363210048-3334-1-git-send-email-csd@broadcom.com>
 <1363210048-3334-2-git-send-email-csd@broadcom.com>
 <CAGFynZ_YEHbUQxGFgp_SA__4xRge64oQ-y5ypXhV5mhtM2k4+w@mail.gmail.com>
Message-ID: <20130402204301.GF8015@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 09:07:41AM -0700, Christian Daudt wrote:
> Hi Grant,
>  In discussion with Olof @ Connect, he suggested that it would be best
> to send dt changes as a standalone patch to devicetree-discuss list to
> get it applied on its own. Can you pls apply this patch ?

Actually, I wanted them split but since these change the SoC dtsi it should
probably still go through arm-soc. I've applied it to our next/soc branch now.


Based on the thread, it looks like the main driver is picked up by John and
will go in that through his tree.

Thanks for your patience on dealing with this!



-Olof
