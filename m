From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 16 Nov 2017 08:55:30 -0800
Subject: [PATCH v2 05/18] arm64: fix -m for GNU gold
In-Reply-To: <20171116105541.fqf3zgrqnbug7deq@yury-thinkpad>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-6-samitolvanen@google.com>
 <20171116105541.fqf3zgrqnbug7deq@yury-thinkpad>
Message-ID: <CAKwvOd=-n1ryFh+scD3WzQ1wJ9tKQAuy2Pi6fowd74iFeC6wPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This and the ld-name patch can probably be taken separately from the
rest in the LTO series simply for enabling linking w/ gold.
