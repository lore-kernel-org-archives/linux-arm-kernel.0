From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 06 Nov 2015 12:04:07 -0800
Subject: [PATCH 0/3] Remove the need for qcom,{msm-id,board-id,pmic-id}
In-Reply-To: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Mon, 26 Oct 2015 14:25:09 -0700")
References: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <7h7fluj3ns.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Stephen Boyd <sboyd@codeaurora.org> writes:

> This patchset documents a compatible string format that encodes
> all the information that was being encoded in qcom specific DT
> properties in downstream msm kernels. The goal being to come
> up with a format that will allow us to express the information
> we want to express without requiring the use of vendor specific
> properties. An updated dtbTool will be released after these new
> bindings are accepted so that users can work with non-updateable
> bootloaders.
>
> This is an attempt to resolve a discussion around March of this year[1]
> where the arm-soc maintainers suggested we express this information
> through the board's compatible string.

Thanks for working on this.  This indeed looks like the right way to
handle this, including updating dtbTool.  Very nice.

I guess the DT maintainers should have a crack at the bindings, but
otherwise it looks good.

Kevin
