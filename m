From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jun 2017 17:10:25 +0100
Subject: [PATCHv2] ARM32: Support mremap() for sigpage/vDSO
In-Reply-To: <7dd80420-0f3f-42e2-80e4-e47990f3b20b@virtuozzo.com>
References: <20170414132529.8337-1-dsafonov@virtuozzo.com>
 <871579ef-ee9a-c321-80e4-47836bb0e472@virtuozzo.com>
 <bebbe3ce-12ed-419a-248a-55f41d74d9da@virtuozzo.com>
 <20170523200946.GG22219@n2100.armlinux.org.uk>
 <7dc84202-9f12-4f0e-a925-e050974e17b9@virtuozzo.com>
 <CALCETrV9khCCCAu4G0nfttKV1ZfrxH6dkeSqsqwrngs-WYbpog@mail.gmail.com>
 <7dd80420-0f3f-42e2-80e4-e47990f3b20b@virtuozzo.com>
Message-ID: <20170619161025.GH4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 05:50:23PM +0300, Dmitry Safonov wrote:
> Should I resend this with ack, or send it to your patch system,
> or you'll take it from mail?

As most of it is ARM stuff, I suppose it should go via the ARM tree
unless anyone has objections.  Please put it in the patch system as
I won't get to it until towards the end of this week (I'm remotely
attending a conference.)  Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
