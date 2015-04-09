From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Apr 2015 08:45:58 +0100
Subject: [RFC PATCH] ARM: debug: Add prompt for FRAME_POINTER to
 Kconfig.debug
In-Reply-To: <1428537883-19622-1-git-send-email-gregory.0xf0@gmail.com>
References: <1428537883-19622-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <20150409074558.GT12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 05:04:43PM -0700, Gregory Fong wrote:
> Without a prompt string, it is impossible to disable FRAME_POINTER on
> ARM. It will simply set the default value anytime you run 'make'.

Have you read the comment above it?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
