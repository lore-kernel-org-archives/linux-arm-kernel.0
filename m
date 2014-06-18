From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jun 2014 20:01:09 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20140618190108.GI32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 06:54:24PM +0200, Pali Roh?r wrote:
> Machine name from board description is some generic name on DT kernel.
> DT provides machine name property which is specific for board, so use
> it instead generic one when possible.

http://archive.arm.linux.org.uk/lurker/message/20130726.132850.53d47576.en.html

"If userspace wants to get at the DT information about a platform, we already
have ways that can happen already - we export the DT stuff so that kexec's
tools can get at it."

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
