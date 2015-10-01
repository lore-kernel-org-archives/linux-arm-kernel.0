From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 01 Oct 2015 17:17:07 +1000
Subject: [PATCH v5 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <CAFpQJXXKcwks0iZN+3B=U0-9uYKFpAXcZE90GCHN9WyM45Hdpw@mail.gmail.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20150828123228.GE31748@leverpostej>
 <CAFpQJXWzM644KsFWP9ei-k6gWgNVpBVT+UbY7NYdyfmyL=zMkw@mail.gmail.com>
 <CAFpQJXWFx2dQ_vv0POqkOiLe3eh9Ee=Sf+2Xx_08Vp=E4g6gLQ@mail.gmail.com>
 <20150930105331.GA10066@leverpostej>
 <CAFpQJXVegqortRLK+g7_9p82KMYwq0hg8n3_9bJqjGHsJvngaA@mail.gmail.com>
 <1443661547.2828.40.camel@kernel.crashing.org>
 <CAFpQJXXKcwks0iZN+3B=U0-9uYKFpAXcZE90GCHN9WyM45Hdpw@mail.gmail.com>
Message-ID: <1443683827.2828.46.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-01 at 10:41 +0530, Ganapatrao Kulkarni wrote:
> i still could not represent the ring/mesh numa topology using
> associativity, which will be present in other upcoming arm64
> platforms.

Right. It should be possible to represent it using the multiple list as
a multi-path problem, but it's a bit awkward.

It does look like the representation might not work well for that case

Cheers,
Ben.
