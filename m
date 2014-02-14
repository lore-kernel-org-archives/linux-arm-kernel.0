From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Feb 2014 22:49:06 -0700
Subject: [PATCH 2/2] ARM: bcm2835: add unit address to all nodes w/ reg
 prop
In-Reply-To: <1392181392-29694-2-git-send-email-swarren@wwwdotorg.org>
References: <1392181392-29694-1-git-send-email-swarren@wwwdotorg.org>
 <1392181392-29694-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52FDAE52.2010500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2014 10:03 PM, Stephen Warren wrote:
> DT nodes that contain a reg property should include a unit address in
> their name. Add the missing unit addresses.

I've dropped this one patch; I noticed it causes some issues with
clocks, and some of the already-existing node name unit addresses need
cleaning up too.
