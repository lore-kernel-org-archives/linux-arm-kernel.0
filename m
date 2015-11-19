From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 19 Nov 2015 13:33:41 -0800
Subject: [PATCH RFC 03/27] PM / Domain: Add additional state specific param
In-Reply-To: <1447799871-56374-4-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Tue, 17 Nov 2015 15:37:27 -0700")
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hpoz5u11m.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Allow domain states to hold additional state related data in a u32
> value. This may be used by the platform driver.

Should probably expand the changelog here to give some examples how how
this might be used by the platform driver.

Kevin
