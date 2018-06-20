From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Jun 2018 16:43:59 -0300
Subject: [PATCH v3 17/17] kasan: add SPDX-License-Identifier mark to
 source files
In-Reply-To: <CAAeHK+zJgSAxiHHfzhrm7N7iey7CbW42WfWvUN+FnZMPP3FXrA@mail.gmail.com>
References: <cover.1529515183.git.andreyknvl@google.com>
 <f76d3070776e0038eda3cd76d471d1bfeae18480.1529515183.git.andreyknvl@google.com>
 <CAOMZO5BgPaMsmx_3AJvMTKCFjhusfH=kH26U_PQCSD5TcUDA+w@mail.gmail.com>
 <CAAeHK+zJgSAxiHHfzhrm7N7iey7CbW42WfWvUN+FnZMPP3FXrA@mail.gmail.com>
Message-ID: <CAOMZO5APF=cYOia8dn7dHa3h-Tm6sFMsJZwie--T6N-1-X-TYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 4:41 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

> I used mm/slub.c as a reference, which uses //. Bu I can change it to
> /* */ in the next version, no problem.

C source files should use //. C header files should use /* */

This is documented at Documentation/process/license-rules.rst
