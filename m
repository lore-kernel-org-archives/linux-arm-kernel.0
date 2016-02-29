From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 29 Feb 2016 18:39:01 +0300
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <208897488.c0hkBy2G1S@wuerfel>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <208897488.c0hkBy2G1S@wuerfel>
Message-ID: <20160229153901.GA27327@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 09:23:35AM +0100, Arnd Bergmann wrote:
> I have no idea whether this is good news or bad news ;-)

This is neutral news, I think. V5 had ~25 fails, and aarch32 and lp64 has
~5 fails each. I believe I'll manage to achieve ~25 fails soon. The
rest fails are not clear for me now, so I'll investigate it...
