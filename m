From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 29 Oct 2014 16:53:50 -0700
Subject: [PATCH 3/4] PM / Domains: Improve error handling while
 adding/removing devices
In-Reply-To: <1414507090-516-4-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Tue, 28 Oct 2014 15:38:09 +0100")
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
 <1414507090-516-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7h8ujy5t69.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> To improve error handling while adding/removing devices from their PM
> domains, we need to restructure the code a bit. Let's do this by moving
> the device specific parts into a separate function.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This looks like just restructuring, but with these kinds of patches, its
hard to be sure that it's just refactoring, with no functional changes,
so it's nice to be clear in the changelog whether there are (meant to
be) any functional changes.

Kevin
