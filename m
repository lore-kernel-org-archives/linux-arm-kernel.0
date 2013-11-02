From: robherring2@gmail.com (Rob Herring)
Date: Fri, 1 Nov 2013 20:00:27 -0500
Subject: [PATCH 01/11] devicetree: bindings: Document cpu enable-method
 for ARM CPUs
In-Reply-To: <1383343739-23080-2-git-send-email-sboyd@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
 <1383343739-23080-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAL_Jsq+_Z8s1on3zbwUSV8y3hq9FE4hejLEzMAfNy1nz8KfsQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 1, 2013 at 5:08 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> From: Rohit Vaswani <rvaswani@codeaurora.org>
>
> According to the ePAPR CPUs should have an enable method. On ARM
> the enable-method property has not been used so far, so document
> this property as an optional property and add the spin-table
> method as one value
>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
> [sboyd: Split off into separate patch]
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Rob Herring <rob.herring@calxeda.com>
