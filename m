From: robherring2@gmail.com (Rob Herring)
Date: Tue, 29 Oct 2013 00:50:30 -0500
Subject: [PATCH v3 01/10] of: Add empty for_each_available_child_of_node()
 macro definition
In-Reply-To: <3518ab21e436f5c1a7bdd900a796bb05f9162bbf.1382985169.git.joshc@codeaurora.org>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <3518ab21e436f5c1a7bdd900a796bb05f9162bbf.1382985169.git.joshc@codeaurora.org>
Message-ID: <CAL_Jsq+n_cAGXJaxPrRNOeb1-39EMWokCEFJ3Z3OQydJaRbijQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 1:12 PM, Josh Cartwright <joshc@codeaurora.org> wrote:
> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> Add this empty macro definition so users can be compiled without
> excluding this macro call with preprocessor directives when CONFIG_OF
> is disabled.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

I'm assuming the rest of this is not going to make 3.13, so I've
applied this for 3.13.

Rob
